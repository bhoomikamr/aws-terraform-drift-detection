resource "aws_autoscaling_group" "asg" {
  name = "${var.project_name}-asg"

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns   = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
  health_check_type = "ELB"
  health_check_grace_period = 300
}