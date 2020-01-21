module.exports = async function(req, res) {
  const postId = req.param('id');
  try {

    await FeedItem.update({
      post: postId,
      user: req.session.userId
    }).set({hasLiked: true});

    var createdLike = await Like.create({
      post: postId,
      user: req.session.userId
    });

    await Post.addToCollection(postId, 'likes', createdLike.id);

    const numLikes = await Like.count({post: postId});

    await Post.update({
      id: postId
    }).set({numLikes: numLikes});

    res.end();
  } catch(err) {
    res.serverError(err.toString());
  }
}