module.exports = async function(req, res) {
  console.log('Create comment here: ' + req.param('id'));
  res.end();
}