# # Amazon EMR
# # # # # # # #


# # Amazon EMR Cluster
# resource "aws_emr_cluster" "emr_cluster" {
#   name          = "emr-cluster"
#   release_label = "emr-6.5.0"  # Adjust to your desired EMR version
#   applications  = ["Hadoop", "Hive", "Spark"]  # Add other applications as needed

#   ec2_attributes {
#     key_name = var.key_pair_name  # Replace with your key pair name
#     instance_profile = aws_iam_instance_profile.emr_instance_profile.arn
#   }

#   instances {
#     master_instance_group {
#       instance_type = "m5.xlarge"  # Adjust instance types as needed
#       instance_count = 1
#     }

#     core_instance_group {
#       instance_type = "m5.xlarge"  # Adjust instance types as needed
#       instance_count = 2
#     }
#   }

#   configurations_json = jsonencode([
#     {
#       classification = "spark-defaults",
#       properties = {
#         "spark.driver.memory" = "4g",
#         "spark.executor.memory" = "2g",
#       },
#     },
#     {
#       classification = "hive-site",
#       properties = {
#         "javax.jdo.option.ConnectionURL" = "jdbc:mysql://your-database-endpoint:3306/your-database-name",
#         "javax.jdo.option.ConnectionDriverName" = "org.mysql.Driver",
#         "javax.jdo.option.ConnectionUserName" = "your-database-username",
#         "javax.jdo.option.ConnectionPassword" = "your-database-password",
#       },
#     },
#   ])

#   step {
#     name = "Process Curated Data"
#     action_on_failure = "TERMINATE_CLUSTER"
#     hadoop_jar_step {
#       jar  = "command-runner.jar"
#       args = ["spark-submit", "--class", "YourSparkAppClass", "s3://curated-data-bucket/your-spark-job.jar"]
#     }
#   }
# }
