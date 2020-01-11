module.exports = async function(req, res) {
  const currentUserId = req.session.userId;
  const userIdToUnfollow = req.param('id');

  await userIdToUnfollow.removeFromCollection(currentUserId, 'following', userIdToUnfollow);

  res.end();
}