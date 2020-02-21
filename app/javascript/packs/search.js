import algoliasearch from "algoliasearch/lite";

var client = algoliasearch("", "");
var index = client.initIndex('Post_dev');
index.search('ss', { hitsPerPage: 10, page: 0 })
  .then(function searchDone(content) {
    console.log(content.hits[0])
  })
  .catch(function searchFailure(err) {
    console.error(err);
  });