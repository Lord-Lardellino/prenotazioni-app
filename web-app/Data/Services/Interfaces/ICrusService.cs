using Piscina.Data.Commons;

namespace Piscina.Data.Services.Interfaces
{
    public interface ICrusService<T> where T : class
    {

        List<ServiceResponse<T>> GetAll();
        ServiceResponse<T> Get(int id);
        ServiceResponse<T> Create(T item);
        ServiceResponse<T> Update(T item);
        ServiceResponse<T> Delete(int id);

    }
}
