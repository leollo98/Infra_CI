module "homolog" {
    source = "../../infra"

    nome_repositorio = "homolog"
    cargoIAM = "homolog"
    ambiante = "homolog"
    imagem="leonardosartorello/go_ci:22"
}

output "IP_alb" {
  value = module.homolog.IP
}
