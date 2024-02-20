const express = require("express");
const router = express.Router();


router.get("/", async (req, res) => {
    try {
        res.send({
            ts: new Date(),
            mgs: 'Everything looks fine here....'
        });
    } catch (error) {
        res.send(error);
    }
});

module.exports = router;
