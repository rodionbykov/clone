component extends="testbox.system.BaseSpec" {

  function beforeAll() {}

  function afterAll() {}

  function run( testResults, testBox ){

      describe("A suite", function(){
            it("contains spec with an awesome expectation", function(){
                expect( true ).toBeTrue();
            });
      });

  }

}