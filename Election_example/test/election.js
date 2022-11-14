const { expect, assert } = require("chai");

var Election=artifacts.require("./election.sol");

contract("Election",function(accounts){


   it("it should have zero condidates after contract deployed", async function(){
      return Election.deployed().then( function(instance){
                     return instance.candidatesCount();
      }).then(function(count){
         assert.equal(count,0);
      });
   
   });
   //    it("it should add condidate in list", async function(){
   //       return Election.deployed()
   //       .then( function(instance){
   //             return instance.addCandidate.call('0xFc7Be89f08b9E69C7B53DfF016eF14bf89eb4ad2','c1');
   //       })
   //       .then(function(list){
   //          assert.equal(list[0].name,'c1',"contains correct name");
   //       });
       

   // });

   
   it("candidate count should increament", async () => 
   {
   return   Election.deployed()
                .then(instance =>{
                   instance.addCandidate('c1');
                  // instance.addCandidate('c12');
                   return instance.candidatesCount();
                  }
                )
                       .then(result =>{
                
                 assert.equal(result,1);
               })
  
    
   });


});