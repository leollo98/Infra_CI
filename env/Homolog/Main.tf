module "homolog" {
    source = "../../infra"

    nome_repositorio = "homolog"
    cargoIAM = "homolog"
    ambiante = "homolog"
}

output "IP_alb" {
  value = module.homolog.IP
}
