
// filename: cap_imageCapture.als
module cap_imageCapture
open IoTBottomUp
one sig cap_imageCapture extends Capability {}
{
  attributes = cap_imageCapture_attr
}
abstract sig cap_imageCapture_attr extends Attribute {}
one sig cap_imageCapture_attr_image extends cap_imageCapture_attr {}
{
  values = cap_imageCapture_attr_val
}
abstract sig cap_imageCapture_attr_val extends AttrValue {}
