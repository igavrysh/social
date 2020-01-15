module.exports = async function(req, res) {
  sails.log.warn("Show the post creation form now");

  //await Post.destroy();
  
  const userId = req.session.userId;
  /*
  const allPosts = await Post.find({user: userId})
    .populate('user')
    .sort('createdAt DESC'); 

  allPosts.forEach(p => p.canDelete = true);
  */

  const allPosts = [];

  const feedItems = await FeedItem.find({user: userId})
    .populate('post')
    .populate('postOwner');
  
  feedItems.forEach(fi => {
    console.log(fi.postOwner);
    fi.post.user = fi.postOwner;
    allPosts.push(fi.post);
  });

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