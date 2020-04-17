# Parsing items and clippings in newspaper.com search results

## Page

```
<div class="record-w clear">
  <div class="record-preview unselect">
    <div class=doc-thumb-container>
      <a class="page-nav previous-ocr-hit" unselectable=on title="Show previous match"></a>
      <a class="page-nav next-ocr-hit" unselectable=on title="Show next match"></a>
      <div class=doc-thumb>
        <a href="https://www.newspapers.com/image/264488506/?terms=%22if%2Bi%2Bshould%2Bdie%2Btonight%22" title="View this paper">
          <img src=data:image/jpeg;base64 alt="The Buffalo Commercial">
        </a>
      </div>
    </div>
  </div>
  <div class=record-content>
    <a href="https://www.newspapers.com/image/264488506/?terms=%22if%2Bi%2Bshould%2Bdie%2Btonight%22">
      <h2>The Buffalo Commercial</h2>
      <i class=news-local title=Location>Buffalo, New York</i>
      <div class=result-breadcrumb>
        <span class="news-date icon-news icon-cal" title=Date>Saturday, June 28, 1873
          - <span class=pageNumber>Page 4</span>
        </span>
        <p class="gray news-match"><b class=ocr-hit-iterator>1</b> of 6 matches on this page.</p>
      </div>
    </a>
    <div>
    </div>
  </div>
</div>
```

## Clipping

```
<div class="record-content">
  <div class="clip-sr">
    <strong class="icon-news icon-clip">Clipping:</strong>
    <a href="https://www.newspapers.com/clip/48538772">
      <h2 class="value" id="spot-48538772">
      "If <span class="highlight">I</span> <span class="highlight">Should</span> <span class="highlight">Die</span> <span class="highlight">Tonight</span> / B.S."
      </h2>
    </a>
  </div>
  <div class="clip-src">
    <a href="https://www.newspapers.com/image/264488506/?terms=%22if%2Bi%2Bshould%2Bdie%2Btonight%22">
      <strong>The Buffalo Commercial</strong>
      <i class="news-local" title="Location">Buffalo, New York</i>
      <span class="news-date icon-news icon-cal" title="Date">Saturday, June 28, 1873 - <span class="pageNumber">4</span>
    </span>
  </a>
</div>
```
