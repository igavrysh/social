module.exports = async function(req, res) {
  console.log("Show post details here");

  const postId = req.param('id');
  const post = await Post.findOne({id: postId})
    .populate('user');

  if (req.wantsJSON) {
    return res.send(post);
  }

  res.view('pages/post/index', {
    layout: 'layouts/nav-layout',
    post: JSON.parse(JSON.stringify(post))
  });
}