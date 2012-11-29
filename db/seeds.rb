# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#livros = Livro.create(
#    [
#        { titulo: 'Guerra e Paz', autor: 'Liev Tolstói' },
#        { titulo: '1984', autor: 'George Orwell' },
#        { titulo: 'Ulisses', autor: 'James Joyce' },
#        { titulo: 'Lolita', autor: 'Vladímir Nabókov' },
#        { titulo: 'O Som e a Fúria', autor: 'William Faulkner' },
#        { titulo: 'O Homem Invisível', autor: 'Ralph Ellison' },
#        { titulo: 'Rumo ao Farol', autor: 'Virginia Woolf' },
#        { titulo: 'Ilíada e Odisseia', autor: 'Homero' },
#        { titulo: 'Orgulho e Preconceito', autor: 'Jane Austen' },
#        { titulo: 'A Divina Comédia', autor: 'Dante Alighieri' },
#        { titulo: 'Os Contos de Cantuária', autor: 'Geoffrey Chaucer' },
#        { titulo: 'As Viagens de Gulliver', autor: 'Jonathan Swift' },
#        { titulo: 'A Vida Era Assim em Middlemarch', autor: 'George Eliot' },
#        { titulo: 'Quando Tudo se Desmorona', autor: 'Chinua Achebe' },
#        { titulo: 'O Apanhador  no Campo de Centeio', autor: 'J. D. Salinger' },
#        { titulo: 'E Tudo o Vento Levou', autor: 'Margaret Mitchell' },
#        { titulo: 'Cem Anos de Solidão', autor: 'Gabriel García Márquez' },
#        { titulo: 'O Grande Gatsby', autor: 'Scott Fitzgerald' },
#        { titulo: 'Catch 22', autor: 'Joseph Heller' },
#        { titulo: 'A Amada', autor: 'Toni Morrison' },
#        { titulo: 'As Vinhas da Ira', autor: 'John Steinbeck' },
#
#    ]
#)

livros = Livro.all

#alunos = Aluno.create(
#    [
#        {nome: 'Joao', cpf: '01999999999'},
#        {nome: 'Maria', cpf: '02999999999'},
#        {nome: 'Juca', cpf: '03999999999'},
#        {nome: 'Ana', cpf: '04999999999'},
#        {nome: 'Antonio', cpf: '05999999999'},
#        {nome: 'Rita', cpf: '06999999999'},
#        {nome: 'Fabio', cpf: '07999999999'},
#        {nome: 'Junior', cpf: '08999999999'},
#        {nome: 'Lucas', cpf: '09999999999'},
#        {nome: 'Iza', cpf: '10999999999'},
#        {nome: 'Fabiana', cpf: '11999999999'},
#        {nome: 'Ricardo', cpf: '12999999999'},
#    ]
#)

alunos = Aluno.all

emprestimos = Emprestimo.create(
    [
        {aluno: alunos[0], livro: livros[0], data_de_emprestimo: 1.day.ago}, #no prazo
        {aluno: alunos[0], livro: livros[1], data_de_emprestimo: 7.day.ago}, #no prazo no limite
        {aluno: alunos[6], livro: livros[8], data_de_emprestimo: 8.day.ago}, #atrasdo
        {aluno: alunos[7], livro: livros[10], data_de_emprestimo: 9.day.ago}, #atrasado
        {aluno: alunos[8], livro: livros[12], data_de_emprestimo: 10.day.ago}, #atrasado
        {aluno: alunos[0], livro: livros[2], data_de_emprestimo: 30.day.ago, data_de_devolucao: 25.day.ago},
        {aluno: alunos[1], livro: livros[0], data_de_emprestimo: 40.day.ago, data_de_devolucao: 35.day.ago},
        {aluno: alunos[1], livro: livros[1], data_de_emprestimo: 50.day.ago, data_de_devolucao: 45.day.ago},
        {aluno: alunos[2], livro: livros[3], data_de_emprestimo: 3.day.ago}, #no prazo
        {aluno: alunos[2], livro: livros[0], data_de_emprestimo: 70.day.ago, data_de_devolucao: 65.day.ago},
        {aluno: alunos[2], livro: livros[4], data_de_emprestimo: 2.day.ago}, #no prazo
        {aluno: alunos[3], livro: livros[1], data_de_emprestimo: 90.day.ago, data_de_devolucao: 85.day.ago},
        {aluno: alunos[4], livro: livros[0], data_de_emprestimo: 100.day.ago, data_de_devolucao: 95.day.ago},
        {aluno: alunos[5], livro: livros[1], data_de_emprestimo: 110.day.ago, data_de_devolucao: 105.day.ago},
    ]
)