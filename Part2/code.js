// ДАНО: Есть дерево, состоящее из двух типов узлов:
// 1. УЗЕЛ: содержит две ветки { left: УЗЕЛ/ЛИСТ, right: УЗЕЛ/ЛИСТ } 
// 2. ЛИСТ: представляет собой строку
// ТРЕБУЕТСЯ: Обойти дерево и вывести для каждого ЛИСТа следующую информацию: 
// <путь>: <3 самых длинных слова из строки>
 
// ПРИМЕР ДАННЫХ
var tree = {
  left: {
      left: "Первое предложение из произвольной строки",
      right: {
          left: "Другое произвольное предложение",
          right: "Еще одно следующее предложение, но не очень длинное"
      }
  },
  right: {
      left: {
          left: {
              left: "Еще одно не очень длинное предложение",
              right: ""
          }, 
          right: {
              left: "",
              right: "Еще одно не очень длинное предложение"
          }
      },
      right: {
          left: {
              left: "Предложение",
              right: "Еще одно следующее предложение, но не очень длинное"
          },
          right: {
              left: "Другое произвольное предложение",
              right: {
                  left: "Два слова",
                  right: "Еще одно следующее предложение, но не очень длинное"
              }
          }
      }
  }
};

// ЗДЕСЬ НАПИСАТЬ КОД. РЕЗУЛЬТАТ ВЫВЕСТИ ЧЕРЕЗ console.log
readTree(tree);
function readTree(obj,path)
{
 if (isNode(obj))
 {
     if (typeof path == 'undefined')
       path=''
     if (path != '')
       path=path+'->'; 

     readTree(obj.left, path+'Left');
     readTree(obj.right, path+'Right');
 } 
 else if (isList(obj))
 {
     console.log(path + ': ' + findLongWords(obj,3))
 }
 return null;
}

function isList(obj){
 if (typeof(obj)=="string")
   return true;
 else
   return false;  
}

function isNode(obj)
{
 if (typeof(obj)=="string")
   return false;
 else
   return true;  
}


function longer(champ, contender) {
 return (contender.length > champ.length) ? contender: champ;
}

function findLongWords(str, word_count) {

   str = str.replace(/[.,!?;|<>]+/g, '');

   var words = str.split(' ');
   var result='';
   for (var i=1;i<=word_count;i++)
   {
       if ((words.length===0) || ((words.length===1) && (words[0]==='')))
         continue;

       var theLongestWord=words.reduce(longer);
       result = result + '|' + theLongestWord;  

       var word = words.indexOf(theLongestWord);
       if(word != -1) {
         words.splice(word, 1);
       }
   }
   return result;
}