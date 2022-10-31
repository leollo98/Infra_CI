module "prod" {
    source = "../../infra"

    nome_repositorio = "producao"
    cargoIAM = "producao"
    ambiante = "producao"
}

output "IP_alb" {
  value = module.prod.IP
}