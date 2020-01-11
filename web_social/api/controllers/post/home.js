module.exports = async function(req, res) {
  sails.log.warn("Show the post creation forn now");

  //await Post.destroy();
  
  const userId = req.session.userId;
  const allPosts = await Post
    .find({user: userId})
    .populate('user')
    .sort('createdAt DESC'); 

  if (req.wantsJSON) {
    return res.send(allPosts);
  }

  /*
  allPosts.forEach(p => {
    p.user = {
      id: p.user.id, 
      fullName: p.user.fullName};
  });
  */

  const string = JSON.stringify(allPosts);
  const objects = JSON.parse(string);
  console.log(string);
  
  res.view('pages/post/home', {
    allPosts: objects,
    layout: 'layouts/nav-layout'
  });
}