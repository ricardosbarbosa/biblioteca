class EmprestimosController < ApplicationController
  # GET /emprestimos
  # GET /emprestimos.json
  def index

    if params[:livro_id]
      @emprestimos = Emprestimo.where(:livro_id => params[:livro_id])
    elsif params[:aluno_id]
      @emprestimos = Emprestimo.where(:aluno_id => params[:aluno_id])
    else
      @emprestimos = Emprestimo.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emprestimos }
    end
  end

  # GET /emprestimos/1
  # GET /emprestimos/1.json
  def show
    @emprestimo = Emprestimo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emprestimo }
    end
  end

  # GET /emprestimos/new
  # GET /emprestimos/new.json
  def new
    @alunos = Aluno.all
    @livros = Livro.all
    @emprestimo = Emprestimo.new
    @emprestimo.data_de_emprestimo = Time.now.to_date

    if params[:livro_id]
      @emprestimo.livro = Livro.find(params[:livro_id])
    end

    if params[:aluno_id]
      @emprestimo.aluno = Aluno.find(params[:aluno_id])
    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emprestimo }
    end
  end

  # GET /emprestimos/1/edit
  def edit
    @emprestimo = Emprestimo.find(params[:id])
  end

  # POST /emprestimos
  # POST /emprestimos.json
  def create
    @emprestimo = Emprestimo.new(params[:emprestimo])
    @emprestimo.data_de_emprestimo = Time.now.to_date

    respond_to do |format|
      if @emprestimo.save
        format.html { redirect_to @emprestimo, notice: 'Emprestimo was successfully created.' }
        format.json { render json: @emprestimo, status: :created, location: @emprestimo }
      else
        format.html { render action: "new" }
        format.json { render json: @emprestimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emprestimos/1
  # PUT /emprestimos/1.json
  def update
    @emprestimo = Emprestimo.find(params[:id])

    respond_to do |format|
      if @emprestimo.update_attributes(params[:emprestimo])
        format.html { redirect_to @emprestimo, notice: 'Emprestimo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emprestimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emprestimos/1
  # DELETE /emprestimos/1.json
  def destroy
    @emprestimo = Emprestimo.find(params[:id])
    @emprestimo.destroy

    respond_to do |format|
      format.html { redirect_to emprestimos_url }
      format.json { head :no_content }
    end
  end
end
