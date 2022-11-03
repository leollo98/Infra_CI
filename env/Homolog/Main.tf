module "homolog" {
    source = "../../infra"

    nome_repositorio = "homolog"
    cargoIAM = "homolog"
    ambiante = "homolog"
    imagem="leonardosartorello/go_ci:100"
}

output "IP_alb" {
  value = module.homolog.IP
}
