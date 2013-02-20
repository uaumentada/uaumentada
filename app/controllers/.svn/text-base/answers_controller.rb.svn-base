class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.xml
  def index
    @answers = Answer.find(:all, :conditions => {:survey_id => params[:survey_id]})
    @survey = Survey.find(params[:survey_id].to_i)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@answer, :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end


def send_answer
question_id = params[:question_id]
id_questions = question_id.split('@@')
answers = params[:answer].split('@@')
group = Answer.find(:all, :conditions => {:survey_id => params[:survey_id]}).count + 1
university = University.find(:first, :conditions => {:email => params[:university_id]})
user = User.find(:first, :conditions => {:email => params[:user_id], :university_id => university.id})

for i in 0..(answers.length-1)

  question_type = Question.find(:first, :conditions => {:id => id_questions[i]}).question_type
  if question_type != 2 #Es diferente a checkbox

     @answer = Answer.create(
	:group => group,
	:user_id => user,
	:survey_id => params[:survey_id],
	:question_id => id_questions[i],
	:answer => answers[i])
  else #Checkbox es el unico que tiene mas de una respuesta
  
     split_answers = answers[i].split('-')

     for j in 0..(split_answers.length-1) #Se crea una respuesta por cada check
     @answer = Answer.create(
	:group => group,
	:user_id => user,
	:survey_id => params[:survey_id],
	:question_id => id_questions[i],
	:answer => split_answers[j])
     end
   end
  end


#solo para el render y que no tire error por ahora
#@survey = Survey.find(:first, :conditions => {:id => params[:id_survey]})
#@questions = Question.find(:all)
 render :xml => {:result => "true"}.to_xml

end

#vista por defecto, ordenado por pregunta
#Parametros:
# survey_id : Encuesta de interés
def view_answers

	#@answers = Answer.find(:all, :conditions => {:id_survey => params[:survey_id]})
	@questions = Question.find(:all, :conditions => {:survey_id => params[:survey_id]}, :order => 'question_number')
	@survey = Survey.find(:first, :conditions=> {:id => params[:survey_id]})
        @numAnswers = Answer.find(:all, :conditions => {:survey_id => params[:survey_id]} ).group_by(&:group).count
	# = answers.count('group', :distinct  => true )

	render "index"
end

#Agrupar las respuestas por usuario (en lugar de por pregunta)
def order_by_user

	@questions = Question.find(:all, :conditions => {:survey_id => params[:survey_id]}, :order => 'question_number')
	@survey = Survey.find(:first, :conditions=> {:id => params[:survey_id]})

end


end
