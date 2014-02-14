
/*
 * GET users listing.
 */

exports.list = function(req, res){
  res.json({status: 1, path: req.path});
};