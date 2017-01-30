Handlebars.registerHelper('ifCond', function(v1, v2, options) {
      //console.log(v1==v2);
      //console.log(v1===v2);
      //console.log(v1);
      //console.log('v2'+v2);
      //console.log(v2);
      //console.log('options');
      //console.log(options);
  if(v1 == v2) {
    return options.fn(this);
  }
  return options.inverse(this);
});

Handlebars.registerHelper('selected', function(option, value){
//      console.log('options');
//      console.log(options);
//      console.log('value');
//      console.log(value);
  if (option === value) {
    return ' selected';
  }
    return this;

});

Handlebars.registerHelper("math", function(lvalue, operator, rvalue, options) {

  lvalue = parseFloat(lvalue);
  rvalue = parseFloat(rvalue);

  return {
    "+": lvalue + rvalue,
    "-": lvalue - rvalue,
    "*": lvalue * rvalue,
    "/": lvalue / rvalue,
    "%": lvalue % rvalue
  }[operator];
});

Handlebars.registerHelper("math", function(lvalue, operator, rvalue, operator2, fvalue,options) {

  lvalue = parseFloat(lvalue);
  rvalue = parseFloat(rvalue);
  fvalue = parseFloat(fvalue);

  return {
    "+": lvalue + rvalue,
    "-": lvalue - rvalue - fvalue,
    "*": lvalue * rvalue,
    "/": lvalue / rvalue,
    "%": lvalue % rvalue
  }[operator];
});

Handlebars.registerHelper('isSelectedOrgan', function (input,organ_seq,mem_type) {
  var str = '';

  if(mem_type == 'O' && input !=organ_seq){
    //console.log(input);
    str = ' disabled';
  }

  return input == organ_seq ? 'selected' +str : ''+str;
});

Handlebars.registerHelper('isSelectedMem', function (input,auth,member_type) {
  var str = '';

  if(auth == 'G' && (input == 'A' || input == 'G' )){
    str = ' disabled';
  }
  if(auth == 'C' && (input == 'A' || input == 'G' || input == 'C' )){
    str = ' disabled';
  }
  if(auth == 'O' && (input == 'A' || input == 'G' || input == 'C' || input == 'O' )){
    str = ' disabled';
  }
  return input == member_type ? 'selected' +str : ''+str;
});

Handlebars.registerHelper('isSelectedOrg', function (input,organ_seq) {
  //console.log(input);
  //console.log(organ_seq);
  var str = '';
  //
  //if(auth == 'G' && (input == 'A' || input == 'G' )){
  //  str = ' disabled';
  //}
  //if(auth == 'C' && (input == 'A' || input == 'G' || input == 'C' )){
  //  str = ' disabled';
  //}
  //if(auth == 'O' && (input == 'A' || input == 'G' || input == 'C' || input == 'O' )){
  //  str = ' disabled';
  //}
  return input ==organ_seq ? 'selected' +str : ''+str;
});


Handlebars.registerHelper("foreach",function(arr,options) {
  if(options.inverse && !arr.length)
    return options.inverse(this);

  return arr.map(function(item,index) {
    item.$index = index;
    item.$first = index === 0;
    item.$last  = index === arr.length-1;
    return options.fn(item);
  }).join('');
});

Handlebars.registerHelper("inc", function(value, options)
{
  return parseInt(value) + 1;
});