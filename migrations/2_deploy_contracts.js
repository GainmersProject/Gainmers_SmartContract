
var GainmersSALE = artifacts.require("./GainmersSALE.sol");

Date.prototype.getUnixTime = function() { return this.getTime()/1000|0 };
    if(!Date.now) Date.now = function() { return new Date(); }
    Date.time = function() { return Date.now().getUnixTime(); }


module.exports = function(deployer) 
{  // StartTime: "Monday 09 April 2018 00:00:00 GMT-5"
    var publicSaleStartTime = new Date("Sun, 08 Apr 2018 19:00:00 GMT").getUnixTime();
    
   // EndTime: "Sun 06 May 2018 24:00:00 GMT-5"
    var publicSaleEndTime   = new Date("Sun, 06 May 2018 19:00:00 GMT").getUnixTime();

    return GainmersSALE.new(
        publicSaleStartTime,
        publicSaleEndTime,
        {gas: 42000000, gasPrice: 35000000000})

        .then(function(result)
        {
            //Showing the Crowdsale Address and the Token address
                 console.log("GainmersSALE            : "+result.address);
                 result.token.call()
                .then(function (res)
                {
                 console.log("GainmersTOKEN           : "+ res);

                });
        });
    };