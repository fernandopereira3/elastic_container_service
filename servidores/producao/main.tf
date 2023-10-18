module "producao" {
  source = "../../devop"
  nome_repositorio = "producao"
  cargoIAM = "producao"
  ambiente = "producao"
}

# output "dns_do_module" {
#   value =  module.producao.ip
# }