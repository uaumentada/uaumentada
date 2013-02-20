require 'bundler/capistrano'
#role :app, 'ec2-204-236-242-203.compute-1.amazonaws.com', 'mmacuna.ing.puc.cl'
#set :user_aws, 'ec2-user'
#set :domain_aws, 'ec2-204-236-242-203.compute-1.amazonaws.com'  # Dominio del cloud
set :domain, 'mmacuna.ing.puc.cl'
#set :applicationdir, "/home/ec2-user/www"  # Aquí es donde estará alojada tu aplicación en el servidor
set :application, 'pucaumentada'
set :user, 'administrator'
set :scm, :subversion
#set(:svn_password) { Capistrano::CLI.password_prompt("Subversion password: ") } 
set :svn_user, 'MariAcuna'#:scm_username, 'user1g3' 
#set(:svn_password) { Capistrano::CLI.password_prompt("Subversion password: ") } 
set :svn_password, 'matrix'
set :applicationdir, "/home/#{user}/pucaumentada"
set :use_sudo, false
# Configuración de svn
set :repository, "https://subversion.assembla.com/svn/puc-aumentada/trunk/pucaumentada"

# Servidores
server domain, :web, :app, :db, :primary => true

#ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "testpablo.pem")]
#ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "neonkey.pem")] 
#ssh_options[:forward_agent] = true

# Otras configuraciones
default_run_options[:pty] = true  # Ignorar errores en consola de Windows
set :chmod755, "app config db lib public vendor script script/* public/disp*"

#set :rails_env, 'development'
set :deploy_to, applicationdir
set :deploy_via, :export

set :default_environment, { 
  'PATH' => "/home/administrator/.rvm/gems/ruby-1.9.2-p290/bin:/home/administrator/.rvm/gems/ruby-1.9.2-p290@global/bin:/home/administrator/.rvm/rubies/ruby-1.9.2-p290/bin:/home/administrator/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby 1.9.2',
  'GEM_HOME' => '/home/administrator/.rvm/gems/ruby-1.9.2-p290',
  'GEM_PATH' => '/home/administrator/.rvm/gems/ruby-1.9.2-p290:/home/administrator/.rvm/gems/ruby-1.9.2-p290@global' 
}

# Reiniciar servidor Passenger luego de hacer deploy
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
