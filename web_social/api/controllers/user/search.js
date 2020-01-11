module.exports = async function(req, res) {
  console.log('Show list of users');

  const users = await User.find({
    id: {'!=': req.session.userId}
  });

  const currentUser = await User.findOne({id: req.session.userId})
    .populate('following');

    const followingDictionary = new Object();

    currentUser.following.forEach(f => {
      followingDictionary[f.id] = f;
    });

    users.forEach(u => {
      u.isFollowing = followingDictionary[u.id] != null;
    });

    /*
    currentUser.following.forEach(f => {
      console.log(f.fullName);
      users.forEach(u => {
        if (f.id == u.id) {
          u.isFollowing = true;
        }
      })
    });
    */

  res.view('pages/user/search', {
    layout: 'layouts/nav-layout',
    users
  });
}