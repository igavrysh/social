module.exports = async function(req, res) {
  console.log('Lets delete our post object');

  const postId = req.param('postId');
  console.log('Deleting post with id: ' + postId);

  try {
    await Post.destroy({id: postId, user: req.session.userId});
    res.end();
  } catch(err) {
    res.serverError(err.toString());
  }

  res.end();
}