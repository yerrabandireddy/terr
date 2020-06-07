provider  "aws" {
   region = "${var.aws_region}"
}

resource "aws_instance" "testinstance"{
   count = "${length(var.no_of_instances)}"
   ami = "${var.ami}"
   instance_type = "${var.instance_type}"
   key_name = "${var.key}"
   user_data = "${file("${var.bootstrap_path}")}"

   tags = {
        Name = "Server-${count.index}"
        }

}