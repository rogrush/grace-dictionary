import "nullNode" as _nullNode

factory method named(name) withKey(key') andValue(value') containingInSubtree(n') {
  def nullNode = _nullNode.named("Null node")
  
  var left is public := nullNode
  var right is public := nullNode
  
  var key is public := key'
  var value is public := value'
  var n is public := n'

  method asString() {
//    Suppressed to avoid printing which is apparently a side effect of some 
//    other operation
//    print ("key: {key}\nvalue: {value}\nnodes in subtree: {n}")
  }
}
