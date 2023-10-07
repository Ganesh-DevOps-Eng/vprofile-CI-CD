resource "null_resource" "remote_exec" {
  connection {
    type        = "ssh"
    host        = data.aws_instance.ec2.public_dns
    user        = "ec2-user"
    private_key = data.aws_key_pair.my_key_pair.key_name
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum install mariadb -y",
      "MYSQL_HOST=$(echo ${data.aws_db_instance.vprofile_rds.endpoint} | cut -d':' -f1)",
      "MYSQL_USER=\"admin\"",
      "MYSQL_PASSWORD=\"matellioPassword123!\"",
      "DATABASE_NAME=\"accounts\"",
      "# Create the database",
      "mysql -h \"$MYSQL_HOST\" -u \"$MYSQL_USER\" -p\"$MYSQL_PASSWORD\" -e \"CREATE DATABASE $DATABASE_NAME;\"",
      "sudo yum install git -y",
      "git clone https://github.com/devopshydclub/vprofile-project.git",
      "cd vprofile-project/",
      "mysql -h \"$MYSQL_HOST\" -u \"$MYSQL_USER\" -p\"$MYSQL_PASSWORD\" accounts < src/main/resources/db_backup.sql"
    ]
  }
}
