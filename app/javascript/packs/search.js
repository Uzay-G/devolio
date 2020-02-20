import algoliasearch from "algoliasearch/lite";

var client = algoliasearch("DDBD0ATDG9", "19016027dabb4420eb74f6cd7463e2c1");
var index = client.initIndex('Post_dev');
index.search('ss', { hitsPerPage: 10, page: 0 })
  .then(function searchDone(content) {
    console.log(content.hits[0])
  })
  .catch(function searchFailure(err) {
    console.error(err);
  });