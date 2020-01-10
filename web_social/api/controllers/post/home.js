module.exports = async function(req, res) {
  sails.log.warn("Show the post creation forn now");

  //await Post.destroy();
  
  const userId = req.session.userId;
  const allPosts = await Post
    .find({user: userId})
    .populate('user')
    .sort('createdAt DESC'); 

  if (req.wantsJSON) {
    console.log('Client wants JSON posts -- sending all posts info');
    console.log(allPosts);
    console.log('End of the payload');
    return res.send(allPosts);
  }

  //return res.send(allPosts);
  
  res.view('pages/post/home', {
    allPosts,
    layout: 'layouts/nav-layout'
  });
}