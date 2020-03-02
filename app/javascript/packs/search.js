import algoliasearch from "algoliasearch/lite";
import instantsearch from 'instantsearch.js';
import { searchBox, hits, pagination } from 'instantsearch.js/es/widgets';


const search = instantsearch({
  indexName: 'dev',
  searchClient: algoliasearch('DDBD0ATDG9', '19016027dabb4420eb74f6cd7463e2c1'),
});


search.addWidget(
  searchBox({
    container: '#searchbox',
  })
);

search.addWidget(
  hits({
    container: '#hits',
    templates: {
      item: `
        <div>
          <div class="hit-name">
            {{#helpers.highlight}}{ "attribute": "title" }{{/helpers.highlight}}
          </div>
        </div>
      `,
    },
  })
);
search.start();

$(".ais-SearchBox-input").on('input', function() {
  $("#hits").css('display', "block");
})