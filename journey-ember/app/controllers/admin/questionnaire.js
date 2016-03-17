// Generated by CoffeeScript 1.10.0
import Ember from 'ember';
var QuestionnaireController;

QuestionnaireController = Ember.Controller.extend({
  actions: {
    createPage: function() {
      var page;
      page = this.get('store').createRecord('page', {
        questionnaire: this.get('content')
      });
      return page.save().then(((function(_this) {
        return function() {
          _this.get('pages').then(function() {
            return _this.get('pages').addObject(page);
          });
          return _this.transitionToRoute('admin.questionnaire.pages.page', page);
        };
      })(this)), function(error) {
        return alert(error);
      });
    },
    deletePage: function(page) {
      if (confirm("Do you really want to delete the page \"" + (page.get('title')) + "\"?")) {
        page.deleteRecord();
        return page.save().then(((function(_this) {
          return function() {
            _this.get('pages').then(function() {
              return _this.get('pages').removeObject(page);
            });
            return _this.transitionToRoute('admin.questionnaire.pages', {questionnaire: this.get('content')});
          };
        })(this)), function(error) {
          return alert(error);
        });
      }
    }
  }
});

export default QuestionnaireController;
