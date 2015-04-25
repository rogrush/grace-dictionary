import "gUnit" as gU
import "bst" as bst

def bstTest = object {
  class forMethod(m) {
    inherits gU.testCaseNamed(m)
  
    def presidents = bst.named("Presidents")
    
    presidents.at("washington") put("george")
    presidents.at("adams") put("john")
    presidents.at("jefferson") put("thomas")
    presidents.at("madison") put("james")
    presidents.at("monroe") put("james")
    presidents.at("quincy adams") put("john")
    presidents.at("jackson") put("andrew")
    
    method testBSTasSet {
      assert (presidents.asSet) shouldBe (set.with("washington"::"george", "adams"::"john", "jefferson"::"thomas", "madison"::"james", "monroe"::"james", "quincy adams" ::"john", "jackson"::"andrew"))
    }
    
    method testBSTasSequence {
      assert (presidents.asSequence) hasType (Sequence)
    }
    
    method testBSTasList {
      assert (presidents.asList) hasType (List)
    }
  }
}

def bstTests = gU.testSuite.fromTestMethodsIn(bstTest)
print "bst"
bstTests.runAndPrintResults
