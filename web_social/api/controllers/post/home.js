module.exports = async function(req, res) {
  sails.log.warn("Show the post creation forn now");

  //await Post.destroy();
  
  const userId = req.session.userId;
  const allPosts = await Post
    .find({user: userId})
    .populate('user')
    .sort('createdAt DESC');  
  
  res.view('pages/post/home', {
    allPosts
  });
}