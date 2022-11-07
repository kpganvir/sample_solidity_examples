
var Election=artifacts.require("./election.sol");

contract("Election" ,function(){
    const eleInstance;
    it("initializaiton of 2 candidates",async function (){
         return Election.deployed()
         .then( function(instance) {
            eleInstance= instance.connect('0x4fe44b94Ac9c6cdb8acdD6CA00b968Dee3721b6E');
            eleInstance.addCandidate('0x4B1B56ECb14436D493f36961eA686BF7ea7F8D09','modi');

          //  instance.addCandidate('0xa861Bd0c985A67c11e1B86102e83BD731d0F77f2','kejriwal');
            return instance.candidatesCount();
         }).then(function(count){
            assert.equal(count,1);
         });


         

    });
   
});