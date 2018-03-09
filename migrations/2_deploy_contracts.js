
var GainmersSALE = artifacts.require("./GainmersSALE.sol");

Date.prototype.getUnixTime = function() { return this.getTime()/1000|0 };
    if(!Date.now) Date.now = function() { return new Date(); }
    Date.time = function() { return Date.now().getUnixTime(); }


module.exports = function(deployer) 
{  console.log("GainmersTOKEN           : "+ Date.now);
   //+5 horas
    var publicSaleStartTime = new Date("Sun, 18 Mar 2018 19:00:00 GMT").getUnixTime();
    var publicSaleEndTime   = new Date("Sun, 15 Apr 2018 19:00:00 GMT").getUnixTime();
   // var tokenSaleContract;
    
    return GainmersSALE.new(
        publicSaleStartTime,
        publicSaleEndTime,
        {gas: 42000000, gasPrice: 35000000000})

        .then(function(result)
        {
            //tokenSaleContract = result;
                 console.log("GainmersSALE            : "+result.address);
            result.token.call()
                .then(function (res)
                {
                 console.log("GainmersTOKEN           : "+ res);

                });
        });
    };