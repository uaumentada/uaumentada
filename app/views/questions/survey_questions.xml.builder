xml.instruct!
xml.questions do
 xml.survey_id @survey.id
  @questions.each do |question|
      xml.question do
      xml.type question.question_type
      xml.id question.id
      xml.question_asked question.question
      xml.help question.help
      xml.mandatory question.mandatory
      xml.answers question.answers
  end
end
end
