
resource "aws_wafv2_rule_group" "wafv2_particular_rule_group" {
	name        = "${local.project_name_prefix}-rule-group"
	description = "A rule group containing rule to block ip,block url, payment api, whitelist,s2s statement,size constraint, xss and sqli string"
	scope       = "REGIONAL"
	capacity    = 300
	rule {
		name     = "${local.project_name_prefix}-blacklist-rule"
		priority = 1
		action {
			block {}
		}
		statement {
			ip_set_reference_statement {
				arn = aws_wafv2_ip_set.ipset_block.arn
				ip_set_forwarded_ip_config {
					fallback_behavior = "MATCH"
					header_name       = "Tata-Client-Ip"
					position          = "FIRST"
				}
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
			metric_name                = "bingeIPBlackListRule"
			sampled_requests_enabled   = var.sampled_requests_enabled
		}
	}
# 	rule {
# 		name     = "${local.project_name_prefix}-block-url-rule"
# 		priority = 2
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.site24_7_ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "CONTAINS_WORD"
# 								search_string         = "swagger"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "NONE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "CONTAINS_WORD"
# 								search_string         = "webjars"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "NONE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "CONTAINS_WORD"
# 								search_string         = "api-docs"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 3
# 									type     = "NONE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "CONTAINS_WORD"
# 								search_string         = "actuator"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 4
# 									type     = "NONE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "CONTAINS"
# 								search_string         = "/dth/user/login"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 5
# 									type     = "NONE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "CONTAINS"
# 								search_string         = "/secure/system/user/login"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 6
# 									type     = "NONE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/dth/user/"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 7
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "blockurlrule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-payment-api-ip-rule"
# 		priority = 3
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_nat_mainsite.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "EXACTLY"
# 						search_string         = "/umbrellamatrix/billdesk/updatePaymentStatus"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "NONE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "paymentapiiprule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-opel-payment-api-rule"
# 		priority = 4
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_opel_payment.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "EXACTLY"
# 						search_string         = "/umbrellamatrix/opel/webHookUrl"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "NONE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "opelpaymentapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-ip-whitelist-rule"
# 		priority = 5
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_nat_mainsite.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-write/core-api/payment-response"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-read/read/core-api/get-cart-detail"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "ipwhitelistrule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-s2s-api-rule"
# 		priority = 6
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_billdesk.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "STARTS_WITH"
# 						search_string         = "/umbrellamatrix/billdesk/billDeskS2SUrl"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "URL_DECODE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "s2sapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-packselector-ip-rule"
# 		priority = 7
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_packselector.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "EXACTLY"
# 						search_string         = "/inception-write/recommended-api/save-data"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "NONE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "packselectoriprule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-secure-api-rule"
# 		priority = 8
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.secure_tcs.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/secure/user/validate"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/secure/user/authByRefresh"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/secure/order/send-order-status"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 3
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/secure/rest-api"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 4
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/secure/order/sms/generateAccountLinkingSMS"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 5
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "secureapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-tcs-api-rule"
# 		priority = 9
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_tcs.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/manage-pack/static-data/insuffbal-addpack"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/manage-pack/static-data/insuffbal-addpack-status"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "tcsapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-tatadigital-ip-rule"
# 		priority = 10
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_tatadigital.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-write/get-connection/redirection"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-auth/journey/save-data"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-pack/service/assetSwap"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 3
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-pack/service/getServices"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 4
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-auth/user/rmn-details"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 5
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/rc/enrollment-journey"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 6
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-transaction/tcp/enrollment"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 7
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-transaction/get-tdigital-offers"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 8
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "tatadigitalwhitelisting"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-bcp-api-rule"
# 		priority = 11
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_bcp.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "STARTS_WITH"
# 						search_string         = "/inception-bcp/v2/request/generate-token"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "URL_DECODE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "bcpapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-otp-api-rule"
# 		priority = 12
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "STARTS_WITH"
# 						search_string         = "/otp-service/"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "URL_DECODE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "otpapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-b2c-api-rule"
# 		priority = 13
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					byte_match_statement {
# 						positional_constraint = "STARTS_WITH"
# 						search_string         = "/inception-transaction/b2c/"
# 						field_to_match {
# 							uri_path {}
# 						}
# 						text_transformation {
# 							priority = 1
# 							type     = "URL_DECODE"
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "b2capirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-ott-api-rule"
# 		priority = 14
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# #				statement {
# #					not_statement {
# #						statement {
# #							ip_set_reference_statement {
# #								arn = aws_wafv2_ip_set.ipset_ott.arn
# #								ip_set_forwarded_ip_config {
# #									fallback_behavior = "MATCH"
# #									header_name       = "Tata-Client-Ip"
# #									position          = "FIRST"
# #								}
# #							}
# #						}
# #					}
# #				}
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-transaction/ott/"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-auth/ott/"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "ottapirule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}
# 	rule {
# 		name     = "${local.project_name_prefix}-ip-api-block-rule"
# 		priority = 15
# 		action {
# 			block {}
# 		}
# 		statement {
# 			and_statement {
# 				statement {
# 					not_statement {
# 						statement {
# 							ip_set_reference_statement {
# 								arn = aws_wafv2_ip_set.ipset.arn
# 								ip_set_forwarded_ip_config {
# 									fallback_behavior = "MATCH"
# 									header_name       = "Tata-Client-Ip"
# 									position          = "FIRST"
# 								}
# 							}
# 						}
# 					}
# 				}
# 				statement {
# 					or_statement {
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-auth/user/validate-token"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 1
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-read/read/core-api/encrypt"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 2
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-auth/secure/"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 16
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 						statement {
# 							byte_match_statement {
# 								positional_constraint = "STARTS_WITH"
# 								search_string         = "/inception-write/secure/"
# 								field_to_match {
# 									uri_path {}
# 								}
# 								text_transformation {
# 									priority = 17
# 									type     = "URL_DECODE"
# 								}
# 							}
# 						}
# 					}
# 				}
# 			}
# 		}
# 		visibility_config {
# 			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
# 			metric_name                = "ipapiblockrule"
# 			sampled_requests_enabled   = var.sampled_requests_enabled
# 		}
# 	}

	visibility_config {
		cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
		metric_name                = lookup(var.wafv2_acl_metric_name, terraform.workspace)
		sampled_requests_enabled   = var.sampled_requests_enabled
	}
	tags = merge(local.common_tags, {"Name": "${local.project_name_prefix}-rule-group"})
}

resource "aws_wafv2_web_acl" "wafv2_web_acl" {
	name        = "${local.project_name_prefix}-web-acl"
	description = "WEB ACL with 10 rule groups for tp-binge"
	scope       = "REGIONAL"
	default_action {
		allow {}
	}

	rule {
		name     = "${local.project_name_prefix}-geo-location-block-rule"
		priority = 0
		action {
			block {}
		}
		statement {
			geo_match_statement {
				country_codes = var.blocked_country_code
				forwarded_ip_config {
					fallback_behavior = "MATCH"
					header_name       = "X-Forwarded-For"
				}
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
			metric_name                = "bingeGeoBlacklistRule"
			sampled_requests_enabled   = var.sampled_requests_enabled
		}
	}

	rule {
		name     = "${local.project_name_prefix}-blacklist-client-ip-rule"
		priority = 1
		action {
			block {}
		}
		statement {
			ip_set_reference_statement {
				arn = aws_wafv2_ip_set.ipset_block_client.arn
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
			metric_name                = "IPBlacklistRule"
			sampled_requests_enabled   = var.sampled_requests_enabled
		}
	}

	rule {
		name     = "${local.project_name_prefix}-aws-manage-rule-1"
		priority = 2

		override_action {
			none {}
		}

		statement {
			managed_rule_group_statement {
				name        = "AWSManagedRulesCommonRuleSet"
				vendor_name = "AWS"
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = true
			metric_name                = "tataplayawscommonset"
			sampled_requests_enabled   = true
		}
	}

	rule {
		name     = "${local.project_name_prefix}-aws-manage-rule-2"
		priority = 3

		override_action {
			none {}
		}

		statement {
			managed_rule_group_statement {
				name        = "AWSManagedRulesSQLiRuleSet"
				vendor_name = "AWS"
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = true
			metric_name                = "tataplayawssqli"
			sampled_requests_enabled   = true
		}
	}
	rule {
		name     = "${local.project_name_prefix}-aws-manage-rule-3"
		priority = 4

		override_action {
			none {}
		}

		statement {
			managed_rule_group_statement {
				name        = "AWSManagedRulesAmazonIpReputationList"
				vendor_name = "AWS"
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = true
			metric_name                = "tataplayawsipreputation"
			sampled_requests_enabled   = true
		}
	}
	rule {
		name     = "${local.project_name_prefix}-aws-manage-rule-4"
		priority = 5

		override_action {
			count {}
		}

		statement {
			managed_rule_group_statement {
				name        = "AWSManagedRulesAnonymousIpList"
				vendor_name = "AWS"
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = true
			metric_name                = "tataplayawsanonymous"
			sampled_requests_enabled   = true
		}
	}
	rule {
		name     = "${local.project_name_prefix}-aws-manage-rule-5"
		priority = 6

		override_action {
			none {}
		}

		statement {
			managed_rule_group_statement {
				name        = "AWSManagedRulesKnownBadInputsRuleSet"
				vendor_name = "AWS"
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = true
			metric_name                = "tataplayawsknownbadinput"
			sampled_requests_enabled   = true
		}
	}
#	rule {
#		name     = "${local.project_name_prefix}-aws-manage-rule-6"
#		priority = 7
#
#		override_action {
#			none {}
#		}
#
#		statement {
#			managed_rule_group_statement {
#				name        = "AWSManagedRulesBotControlRuleSet"
#				vendor_name = "AWS"
#			}
#		}
#		visibility_config {
#			cloudwatch_metrics_enabled = true
#			metric_name                = "bingebotcontrolrule"
#			sampled_requests_enabled   = true
#		}
#	}
	rule {
		name     = "${local.project_name_prefix}-particular-rule"
		priority = 7
		override_action {
			none {}
		}
		statement {
			rule_group_reference_statement {
				arn = aws_wafv2_rule_group.wafv2_particular_rule_group.arn
			}
		}
		visibility_config {
			cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
			metric_name                = lookup(var.wafv2_acl_metric_name, terraform.workspace)
			sampled_requests_enabled   = var.sampled_requests_enabled
		}
	}

	visibility_config {
		cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
		metric_name                = lookup(var.wafv2_acl_metric_name, terraform.workspace)
		sampled_requests_enabled   = var.sampled_requests_enabled
	}
	tags = merge(local.common_tags, {"Name": "${local.project_name_prefix}-web-acl"})
}

resource "aws_wafv2_web_acl_logging_configuration" "logging_configuration" {
	log_destination_configs = [lookup(var.logging_s3_bucket_arn, terraform.workspace, "undefined")]
	resource_arn            = aws_wafv2_web_acl.wafv2_web_acl.arn
}

#resource "aws_wafv2_web_acl_association" "waf_load_balancer_association" {
#	resource_arn = data.terraform_remote_state.common_alb.outputs.alb_arn
#	web_acl_arn  = aws_wafv2_web_acl.wafv2_web_acl.arn
#}