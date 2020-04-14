INGEST_REPORTS_LOCATION = Rails.root.join('tmp/ingest_reports')
INDEX_OFFSET = 1
# adapted from https://github.com/ualbertalib/jupiter/blob/integration_postmigration/lib/tasks/batch_ingest.rake

namespace :ingest do
  desc 'Ingest newspapers.com item list from csv file'
  task :ingest_csv, [:csv_path] => :environment do |_t, args|
    require 'csv'
    require 'fileutils'
    require 'byebug'

    log 'START: Batch ingest started...'

    csv_path = args.csv_path

    if csv_path.blank?
      log 'ERROR: CSV path must be present. Please specify a valid csv_path as an argument'
      exit 1
    end

    full_csv_path = File.expand_path(csv_path)
    csv_directory = File.dirname(full_csv_path)

    if File.exist?(full_csv_path)
      successful_ingested_items = []

      CSV.foreach(full_csv_path,
                  headers: true,
                  header_converters: :symbol,
                  converters: :all).with_index(INDEX_OFFSET) do |item_data, index|
        item = item_ingest(item_data, index, csv_directory)

        successful_ingested_items << item
      end

      log 'FINISH: Batch ingest completed!'
    else
      log "ERROR: Could not open file at `#{full_csv_path}`. Does the csv file exist at this location?"
      exit 1
    end
  end
end

def log(message)
  puts "[#{Time.current.strftime('%F %T')}] #{message}"
end

def item_ingest(item_data, index, csv_directory)
  log "ITEM #{index}: Starting ingest of an item..."

  item = Item.new.tap do |i|
    i.filename = item_data[:filename]
    i.publication = item_data[:publication]
    i.location = item_data[:location]
    i.date = item_data[:date]
    i.page = item_data[:page]
    i.url = item_data[:url]
    i.category_id = 1
    i.save!
  end

  log "ITEM #{index}: Starting ingest of file for item..."

  item.thumbnail.attach(
    io: File.open("#{csv_directory}/../thumbnails/#{item_data[:filename]}.jpg"),
    filename: 'thumbnail.jpg'
  )

  sleep(1)

  item
rescue StandardError => e
  log 'ERROR: Ingest of item failed! The following error occured:'
  log "EXCEPTION: #{e.message}"
  log 'WARNING: Please be careful with rerunning batch ingest! Duplication of items may happen '\
      'if previous items were successfully deposited.'
  exit 1
end
