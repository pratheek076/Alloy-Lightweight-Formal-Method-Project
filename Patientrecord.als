sig Doctor {}
sig Patient {}

sig SessionToken {
  var issuedTo: lone Doctor 
}

sig Record {
  owner     : one Patient,
  treatedBy : one Doctor
}

var sig loggedInDoctor in Doctor {}
var sig activeToken in SessionToken {}
var sig visibleRecord in Record {}

fact init {
  no loggedInDoctor
  no activeToken
  no visibleRecord
  no issuedTo 
all p:Patient| one owner.p
all d: Doctor | lone issuedTo.d
#Doctor=2
}

pred login[d: Doctor, t: SessionToken] {
  no loggedInDoctor
  no t.issuedTo

  loggedInDoctor' = d
  activeToken'    = t
  issuedTo'    = issuedTo + (t -> d)
  no visibleRecord'
}

pred viewRecord[r: Record] {
  some loggedInDoctor
  some activeToken // some - existenial quantifier
  activeToken.issuedTo  = r.treatedBy

  visibleRecord'  = r
  loggedInDoctor' = loggedInDoctor
  activeToken'    = activeToken
  issuedTo'    = issuedTo 
}

pred logout {
  some loggedInDoctor
  no loggedInDoctor'
  no visibleRecord'

  //activeToken' = activeToken
 no activeToken'
  issuedTo'    = issuedTo
//no activeToken'
//issuedTo' = issuedTo - (activeToken -> Doctor) // remove token mapping to user after logout
}

pred stutter {
  loggedInDoctor' = loggedInDoctor
  activeToken'    = activeToken
  issuedTo'    = issuedTo
  visibleRecord'  = visibleRecord
}

fact transitions {
  always (
    (some d: Doctor, t: SessionToken | login[d, t]) or
    (some r: Record | viewRecord[r]) or
    logout or
    stutter
  )
}

assert NoSessionLeak {
  always (
    some visibleRecord implies
      visibleRecord.treatedBy = loggedInDoctor
  )
}

assert NoOldSession {
  always (
    (some loggedInDoctor and no loggedInDoctor') implies
     no issuedTo'

  )
}
check NoOldSession for 4
//check NoSessionLeak for 4
//run {} for 3
