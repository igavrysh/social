module.exports = async function(req, res) {
  console.log('Show list of users');

  const users = await User.find({
    id: {'!=': req.session.userId}
  });

  res.view('pages/user/search', {
    layout: 'layouts/nav-layout',
    users
  });
}