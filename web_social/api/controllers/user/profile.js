module.exports = async function(req, res) {
  const currentUser = await User.findOne({id: req.session.userId})
    .populate('following')
    .populate('followers');

    const userId = req.session.userId;

    const posts = await Post.find({user : userId})
      .sort('createdAt DESC')
      .populate('user')
      .populate('like');

    await posts.forEach(async p => {
      p.canDelete = true;

      const likeSaved = await Like.find({post: p.id, user: userId});
      console.log("123: " + likeSaved);
    });


    const firstPostId = posts[0].id;
    console.log('firstPostId: ' + firstPostId);

    currentUser.posts = posts;

    if (req.wantsJSON) {
      res.send(currentUser);
      return;
    }

    // customToJSON

    const sanitizedUser = JSON.parse(JSON.stringify(currentUser));

    console.log('sanitizedUser: ' + JSON.stringify(sanitizedUser));

    res.view('pages/user/profile', {
      layout: 'layouts/nav-layout',
      user: currentUser
    })
}