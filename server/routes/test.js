
/*
 * Get test listing.
 */

/*
 * Test body
 * curl -H "Content-Type: application/json" -d '{"a":100}' --user admin:creativeproject localhost:3000/tests
 */
exports.json_body = function(req, res){
    res.json({status: 1, path: req.path, params: req.body});
};