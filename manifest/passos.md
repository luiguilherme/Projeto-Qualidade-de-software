Dentro da brench em questão, todos os compoenentes vlocity subiram para a org de staging.

Alguns poucos componentes deram problema na subida, alguns deles foram por conta da dependencia do campo hasPortability na ordem.

O campo é utilizado para disparar o cenário quando não há portabilidade.

o card PrePaidAssetDetails estava disparando um erro pois ele tentava desativar uma variável expostas(recordId) que esta sendo utilizada nas opções de publicação.

Da data de ontem estavamos testando a subida dos relatórios.

Acontece que, pegamos erros por conta de dependência, ao meu ver devemos tentar uma abordagem:

No primeiro pacote: Vamos subir os itens de vlocity(Não esquecer o Campo has portability senão dará erro.) + os metadados de campos, e pedir para serem criadas as pastas dos relatórios.
No segundo pacote enviamos o restante dos metadados inclusive o APP administrativo, ontem tentando subir sem os relatórios retornou um erro pois existe um dashboard dentro que não foi encontrado.

