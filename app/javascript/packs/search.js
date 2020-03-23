import algoliasearch from "algoliasearch/lite";
import instantsearch from 'instantsearch.js';
import { searchBox, infiniteHits, pagination } from 'instantsearch.js/es/widgets';


const search = instantsearch({
  indexName: 'dev',
  searchClient: algoliasearch('DDBD0ATDG9', '19016027dabb4420eb74f6cd7463e2c1'),
});


search.addWidget(
  searchBox({
    container: '#searchbox',
    placeholder: "Enter your search query...",
    showSubmit: false,
    showReset: false
  })
);

search.addWidget(
  infiniteHits({
    container: '#hits',
    templates: {
      item: `

        <h2>
          {{#helpers.highlight}}{ "attribute": "title" }{{/helpers.highlight}}
        </h2>
        <span class="post-content">
          {{#helpers.highlight}}{ "attribute": "body" }{{/helpers.highlight}}
            <a href='{{ relative_url }}' class='btn-white' style="display: block; margin: 10px 0px">See more</a>
        </span>
      `,
    },
  })
);
search.start();

$(".ais-SearchBox-input").on('input', function() {
  $("#hits").css('display', "block");
})
