module.exports = async function(req, res) {
  console.log('User id to follow: ' + req.param('id'));

  // association
  const currentUserId = req.session.userId;
  const userIdToFollow = req.param('id')
  
  await User.addToCollection(currentUserId, 'following', userIdToFollow);

  await User.addToCollection(userIdToFollow, 'followers', currentUserId);

  res.end();
}