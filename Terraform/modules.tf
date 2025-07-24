module "module_aef" {
  count            = var.AEF ? 1 : 0
  source           = "./module_aef"
  certificat       = local.my_env.certificat
  ingress_hostname = local.my_env.aef_ingress_hostname
  image_version    = local.my_env.aef_image_version
}

module "module_codecoveragewatcher" {
  count            = var.codecoveragewatcher ? 1 : 0
  source           = "./module_codecoveragewatcher"
  certificat       = local.my_env.certificat
  nfsserver        = local.my_env.nfsserver
  ingress_hostname = local.my_env.codecoveragewatcher_ingress_hostname
}

module "module_codescene" {
  count            = var.codescene ? 1 : 0
  source           = "./module_codescene"
  certificat       = local.my_env.certificat
  nfsserver        = local.my_env.nfsserver
  script           = file("${path.root}/scripts/codescene.sh")
  ingress_hostname = local.my_env.codescene_ingress_hostname
}

module "module_githubissues" {
  count            = var.githubissues ? 1 : 0
  source           = "./module_githubissues"
  certificat       = local.my_env.certificat
  nfsserver        = local.my_env.nfsserver
  ingress_hostname = local.my_env.githubissues_ingress_hostname
}

module "module_shieldsio" {
  count            = var.shieldsio ? 1 : 0
  source           = "./module_shieldsio"
  certificat       = local.my_env.certificat
  script           = file("${path.root}/scripts/shieldio.sh")
  ingress_hostname = local.my_env.shieldsio_ingress_hostname
}

module "module_sonarqube" {
  count            = var.sonarqube ? 1 : 0
  source           = "./module_sonarqube"
  certificat       = local.my_env.certificat
  nfsserver        = local.my_env.nfsserver
  script           = file("${path.root}/scripts/sonarqube.sh")
  conf             = file("${path.root}/scripts/sonarqube_conf.sh")
  ingress_hostname = local.my_env.sonarqube_ingress_hostname
}

module "module_balboainstallersreferential" {
  count            = var.balboainstallersreferential ? 1 : 0
  source           = "./module_balboainstallersreferential"
  certificat       = local.my_env.certificat
  nfsserver        = local.my_env.nfsserver
  ingress_hostname = local.my_env.balboainstallersreferential_ingress_hostname
}

module "module_teamcity" {
  count  = var.TeamCity ? 1 : 0
  source = "./module_teamcity"
}

module "module_vault" {
  count            = var.vault ? 1 : 0
  source           = "./module_vault"
  certificat       = local.my_env.certificat
  nfsserver        = local.my_env.nfsserver
  k8sExternalIP    = local.my_env.k8sExternalIP
  ingress_hostname = local.my_env.vault_ingress_hostname
}

module "module_neo4j" {
  count                     = var.neo4j ? 1 : 0
  source                    = "./module_neo4j"
  certificat                = local.my_env.certificat
  database_certificat       = local.my_env.certificat
  ingress_hostname          = local.my_env.neo4j_web_ingress_hostname
  ingress_database_hostname = local.my_env.neo4j_database_ingress_hostname
  kubernetes_namespace      = "neo4j"
  storage_class_name        = local.my_env.main_storageClass_name
}

module "module_csi-driver-nfs" {
  count                            = var.csi-nfs-driver ? 1 : 0
  source                           = "./module_csi-driver-nfs"
  chart_version                    = "v4.9.0"
  storageClass_parameters_server   = local.my_env.nfsserver
  storageClass_parameters_share    = "/mnt/nfs/k8s/"
  storageClass_name                = local.my_env.main_storageClass_name
  storageClass_reclaimPolicy       = "Delete"
  storageClass_volumeBindingMode   = "Immediate"
  storageClass_parameters_onDelete = "retain"
  storageClass_mountOptions        = ["nfsvers=4.1"]
}

module "module_zabbix" {
  count  = var.zabbix ? 1 : 0
  source = "./module_zabbix"
}
