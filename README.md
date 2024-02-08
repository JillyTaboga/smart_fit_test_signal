# smart_fit_test_signal

## Projeto

Pequeno projeto feito para testar o gerenciador de estado [Signals](https://pub.dev/packages/signals).
Para injenção de dependência foi utilizado o Get_it com o Injector.

O projeto foi baseado no [desafio da SmartFit]( <https://github.com/bioritmo/front-end-code-challenge-smartsite>) de modo que os assets, design, dados e regras seguiram a do teste deles.

## Para testar

Este projeto funciona em todas as plataformas atendidas pelo Flutter bastando executar o flutter run considerando que o projeto foi setado via FVM para o flutter 3.16.9,

Um site de exemplo pode ser visto em <https://smartfittest.web.app>.

## Considerações

O signals é simples e prático, sua forma de declaração global traz os benefícios do riverpod, removendo os problemas do Provider que se basea apenas na tipagem.

Contudo o signals se limita ao controle de estado, ou seja, fornecer uma variável observável que causa a reconstrução da tela, semelhante a um ValueNotifier.

Do meu ponto de vista isso é um ponto favorável para o package, pois é menos intrusivo que outros packages, inclusive que o riverpod, que trazem injetores e outras funções que atrelam o desenvolvimento a certos padrões esperados, enquanto o Signals permite que o desenvolvedor adote qualquer design, arquitetura ou padrão.

Porém isso pode ser também um problema, se o desenvolvedor não adotar um mínimo de organização teremos variáveis globais espalhadas pelo projeto inteiro.

Ante sua simplicidade e eficácia acredito ser o melhor controlador de estado disponível no momento e não me surpreenderia se o FlutterTeam o incluísse como parte nativa do SDK.
