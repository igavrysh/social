module.exports = async function(req, res) {
  console.log("Show public profile for user");
  const id = req.param('id');
  const user = await User.findOne({id: id})
    .populate('following')
    .populate('followers');

  console.log('user: ' + user);

  const posts = await Post.find({user: id})
    .populate('user');
  console.log(posts);

  user.posts = posts;

  const objects = JSON.parse(JSON.stringify(user));

  console.log('Public profile object' + objects);

  res.view('pages/user/publicprofile', {
    layout: 'layouts/nav-layout',
    user: objects
  });
}