
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.json({status: 1, path: req.path});
};